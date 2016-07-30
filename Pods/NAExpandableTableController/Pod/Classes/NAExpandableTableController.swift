//
//  NAExpandableTableView.swift
//
//  Created by Nicholas Arciero on 3/5/16.
//

import UIKit

@objc public protocol NAExpandableTableViewDataSource {
    /// Number of sections
    func numberOfSectionsInExpandableTableView(tableView: UITableView) -> Int
    
    /// Number of rows in section at index
    func expandableTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    /// Equivalent to UITableView's cellForRowAtIndexPath - called for all cells except the section title cell (the one that toggles expansion)
    func expandableTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    /// Equivalent to UITableView's cellForRowAtIndexPath - called only for section title cell (the one that toggles expansion)
    func expandableTableView(tableView: UITableView, titleCellForSection section: Int, expanded: Bool) -> UITableViewCell
    
    /// Indicates whether `section` is expandable or not.
    optional func expandableTableView(tableView: UITableView, isExpandableSection section: Int) -> Bool
    
    /// The height of cells within an expandable section
    optional func expandableTableView(tableView: UITableView, heightForRowInSection section: Int) -> CGFloat
    
    /// The height of the expandable section title cell
    optional func expandableTableView(tableView: UITableView, heightForTitleCellInSection section: Int) -> CGFloat
}

@objc public protocol NAExpandableTableViewDelegate {
    
    /// Equivalent to UITableView didSelectRowAtIndexPath delegate method. Called whenever a cell within a section is selected. This is NOT called when a section title cell is selected.
    optional func expandableTableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    
    /// Called when a section title cell is selected
    optional func expandableTableView(tableView: UITableView, didSelectTitleCellInSection section: Int)
    
    /**
     Called when a section is expanded/collapsed.
     - Parameter section: Index of section being expanded/collapsed
     - Parameter expanded: True if section is being expanded, false if being collapsed
     */
    optional func expandableTableView(tableView: UITableView, didExpandSection section: Int, expanded: Bool)
}

public class NAExpandableTableController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    /// Default height to use for all cells (44)
    public var defaultRowHeight: CGFloat = 44
    
    /// Determines if multiple sections can be expanded at the same time. If set to `true`, then only one section can be expanded at a time. If a section is expanded and you try to expand another section, the first one will be collapsed.
    public var exclusiveExpand: Bool = false
    
    public weak var dataSource: NAExpandableTableViewDataSource?
    public weak var delegate: NAExpandableTableViewDelegate?
    
    /// Keeps track of which section indices are expanded
    private var expandDict = [Int: Bool]()
    
    public init(dataSource: NAExpandableTableViewDataSource? = nil, delegate: NAExpandableTableViewDelegate? = nil) {
        super.init()
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource?.numberOfSectionsInExpandableTableView(tableView) ?? 0
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return dataSource?.expandableTableView?(tableView, heightForTitleCellInSection: indexPath.section) ?? defaultRowHeight
        }
        
        return dataSource?.expandableTableView?(tableView, heightForRowInSection: indexPath.section) ?? defaultRowHeight
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Hide headers
        return 0
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRectZero)
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandDict[section] ?? false {
            return 1 + (dataSource?.expandableTableView(tableView, numberOfRowsInSection: section) ?? 0)
        }
        
        return 1
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let dataSource = self.dataSource else {
            return UITableViewCell()
        }
        
        let expandable = dataSource.expandableTableView?(tableView, isExpandableSection: indexPath.section) ?? true
        if indexPath.row == 0 && expandable {
            return dataSource.expandableTableView(tableView, titleCellForSection: indexPath.section, expanded: expandDict[indexPath.section] ?? false)
        }
        
        let rowIndexPath = expandable ? NSIndexPath(forRow: indexPath.row - 1, inSection: indexPath.section) : indexPath
        return dataSource.expandableTableView(tableView, cellForRowAtIndexPath: rowIndexPath)
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Check if the first cell in the section
        let expandable = dataSource?.expandableTableView?(tableView, isExpandableSection: indexPath.section) ?? true
        if indexPath.row == 0 && expandable {
            // Check if this section is already expanded, if so then collapse it
            if expandDict[indexPath.section] ?? false {
                collapseSection(tableView, section: indexPath.section)
            } else {
                // If exclusiveExpand is true, then collapse any expanded sections
                if exclusiveExpand {
                    for (section, expanded) in expandDict where expanded {
                        collapseSection(tableView, section: section)
                    }
                }
                expandSection(tableView, section: indexPath.section)
            }
            
            delegate?.expandableTableView?(tableView, didSelectTitleCellInSection: indexPath.section)
        } else {
            // Need to decrement indexPath.row by 1 because the first row is the title cell
            let rowIndexPath = NSIndexPath(forRow: indexPath.row - 1, inSection: indexPath.section)
            delegate?.expandableTableView?(tableView, didSelectRowAtIndexPath: rowIndexPath)
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }
    
    internal func expandSection(tableView: UITableView, section: Int) {
        expandDict[section] = true
        tableView.beginUpdates()
        
        var indexPaths = [NSIndexPath]()
        if let rows = dataSource?.expandableTableView(tableView, numberOfRowsInSection: section) {
            for rowIndex in 1...rows {
                indexPaths.append(NSIndexPath(forRow: rowIndex, inSection: section))
            }
        }
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
        tableView.endUpdates()
        
        delegate?.expandableTableView?(tableView, didExpandSection: section, expanded: true)
    }
    
    internal func collapseSection(tableView: UITableView, section: Int) {
        expandDict[section] = false
        tableView.beginUpdates()
        
        var indexPaths = [NSIndexPath]()
        if let rows = dataSource?.expandableTableView(tableView, numberOfRowsInSection: section) {
            for rowIndex in 1...rows {
                indexPaths.append(NSIndexPath(forRow: rowIndex, inSection: section))
            }
        }
        
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
        tableView.endUpdates()
        
        delegate?.expandableTableView?(tableView, didExpandSection: section, expanded: false)
    }
}