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
        "AD", "AM", "AMV", "Amg", "AMV", "ANS", "AV", "AVDM", " AVVL", "CL", "CM","DLG", "Eth", "IAD",
        "IAM", "IMA", "IGL", "IMD", "IMA", "LD", "LG", "LHb", "LPMC", "LPMR", "LPLR", "LPLC", "MD",  
        "MG", "MHb", "PaF", "PC", "Po", "Pi", "PVA", "Sc", "SG",
        "PVP", "PIL", "PLi", "PO", "POL", "PoMn", "PoT", "PP", "PrGM", "PV", "PVG",
        "Re", "Reth", "Rh", "RRe", "Rt", "SFO", "SPF", "SPFP", "Sub", "VAM", "VLD", "VA", "VLi", "VLLa",
        "VL", "VM", "VPL", "VPM", "VPPC", "VRe", "Xi"
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