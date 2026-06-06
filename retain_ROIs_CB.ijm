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

    // Array of ROI names to target for deletion or retention PT=Xi=PaXi, LD includs LDDM and LDVL
    targetROINames = newArray(
        "10Cb", "10Cb-gr", "1Cb", "1Cb-gr", "2Cb", "2Cb-gr", "3Cb", "3Cb-gr","4/5Cb", "4/5Cb-gr",
        "4Cb", "5Cb", "6Cb", "6Cb-gr", "7Cb", "7Cb-gr", "8Cb", "8Cb-gr", "9Cb", "9Cb-gr",
        "CBN","Cop", "Cop-gr", "Crus1-gr", "Crus1", "Crus2", "Crus2-gr", "CUL",
        "DN", "Fl", "Fl-gr", "HEM", "Int", "IntA", "IntDL", "IntP", "IntPPC", "Lat",
        "LatPC", "Med", "PFl", "PFl-gr", "PM", "PM-gr", "Sim", "Sim-gr", "VERM"
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