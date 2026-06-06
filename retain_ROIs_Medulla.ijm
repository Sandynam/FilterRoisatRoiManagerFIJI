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
        "AP", "10N", "11N", "12N", "6N", "5Sol", "7N", "5Tr", "A5", "Ad1", "Ad2", "Ad3",
        "Amb", "B4", "Bo", "C1", "C2", "C3", "CeCv", "CI", "Cu", "CuR", "CuD", "CVL", "DCN", "DPGi",
        "DMSp5", "ECu", "EF", "EVe", "Gi", "Gr", "GrC", "InM", "IMV", "In", "Gr","ll", "LRtPC",
        "IO", "IRt", "IS", "Li", "LPCu", "LPGi", "LRt", "MdD", "MdV", "PHY", "PGRNl",
        "MoDC","Mx", "MZ5", "NA1", "NA2", "Pa5", "PaVe", "PCGS", "PCRt", "PCuMx", "RIP", "PrBo",
        "PMn", "PPy", "PrMC", "PSol", "RAmb", "RMg", "Ro", "ROb", "RPa", "RTz", "RVL", "RVRG", "SGl",
        "SMV", "Sol", "Sp5C", "SubP", "Tz", "VC", "VeCb", "X", "Y", "Sp5I", "Sp5O", "Sp5",
        "SubCA", "SubCD", "SubCV"
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