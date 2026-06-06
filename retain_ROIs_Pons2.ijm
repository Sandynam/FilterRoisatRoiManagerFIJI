macro "Remove ROIs By Name" {
    // SET TO TRUE, DELETES THE ROIS IN THE ARRAY, FALSE RETAINS THE SELECTED ROIS IN THE ARRAY
    deleteSpecifiedROIs = false;

    // Initialize variables
    deletedCount = 0;
    deletedROINames = "";
    retainedCount = 0;
    retainedROINames = "";
    count = roiManager("count");
    print("Initial number of ROIs:", count);

    // Array of ROI names to target for deletion or retention
    targetROINames = newArray(
        "5ADi","5Ma", "5LPtg", "5MHy", "5MPt", "5N", "5Sol", "5Te", "5Tr","A7", "B9", "Bar", "CAT","CG", "CGA",
        "CGB", "CGG", "CGO", "CGPn", "CPO", "DLL", "DMTg", "DPO", "DTg", "ERS", "I5",
        "IF5", "ILL", "KF", "LC", "LDTg", "LDTgV", "LPB", "LSO", "NR", 
        "LVPO","MnR", "MPB", "MPL", "MSO", "MVPO", "NA5", "NA7", "P5","Pa5", "PB", "PDTg", "P5",
        "PL", "PLV", "PMnR", "Pn", "PnC","PnO", "PnR","PnV","Pr5", "POR","Rbd", "RC", "ReC", "RIP","RtTg", "SGe", "SOl", "Sph", "SPO", "SPTg", "SOC",
        "Su5", "SubCA", "SubCD", "SubCV","SuL", "SuS", "TrLL", "VLL", "VLTg" 
        );
     
        
    for (i = count-1; i >= 0; i--) {
        name = RoiManager.getName(i);
        isTarget = false;

        // Check if the current ROI name matches any name in the targetROINames array
        for (j = 0; j < targetROINames.length; j++) {
            if (caseSensitiveCompare(name, targetROINames[j])) {
                isTarget = true;
                break; // Exit the loop early if a match is found
            }
        }

        // Determine whether to delete based on the control variable and match status
        if ((deleteSpecifiedROIs && isTarget) || (!deleteSpecifiedROIs && !isTarget)) {
            roiManager("select", i);
            roiManager("delete");
            deletedCount++;
            deletedROINames = deletedROINames + " => " + name;
        } else {
            retainedCount++;
            retainedROINames = retainedROINames + " => " + name;
        }
    }

    // Print summary of actions taken
    if (deleteSpecifiedROIs) {
        print("Mode: Deleting specified ROIs.");
        print("Deleted", deletedCount, "ROIs:");
    } else {
        print("Mode: Retaining specified ROIs and deleting others.");
        print("Deleted", deletedCount, "ROIs:");
    }
    print(deletedROINames);
    
    // Print retained ROIs
    print("Retained", retainedCount, "ROIs:");
    print(retainedROINames);
}

// This function exist because
// .equals does not work,
// .contains makes caseSensitve but deletes what should not,
// == is comparing value without caseSensitive
function caseSensitiveCompare(str1, str2) {
    if (str1.length != str2.length) return false;
    for (k=0; k<str1.length; k++) {
        if (charCodeAt(str1, k) != charCodeAt(str2, k)) {
            return false;
        }
    }
    return true;
}