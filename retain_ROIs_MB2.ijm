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
        "SC", "3PC", "4N", "3N", "4Sh", "APT", "ATg", "BIC", "CIC", "CIF", "CLi", "CnF", "Com", 
        "DCIC", "Dk", "DLPAG", "DMPAG", "DpG", "DpWh", "DR","DRC", "DRD", "DRD", "DRI", "DRL", "DRVL", "DRV", "DT", 
        "ECIC", "ECIC3", "EW", "ECIC1", "ECIC2", "EMi", "I3", "IC", "IF", "InC", "InG", "InWh", "IPC", "IPA",
        "IPI", "IPL", "isRt", "LPAG", "Lth", "MA3", "IP", "LPAG", "IPDL", "IPDM", "LT", "Lth", "MA3", "Me5",
        "mPAG", "MCPC", "MiTg", "MPT", "MPT", "mRt", "MT", "OPT", "Op" ,"OT", "p1PAG", "p1Rt", "PAG", "PRT",
        "PaR", "PBG", "PBP", "Pcom", "Pa4", "PCTg", "PlPAG", "PDR", "PIF", "Pn", "PPT", "PR", "PrC", "RRF",
        "PrCnF", "PrEW", "PTg", "R", "Rbd", "RIs", "RLi", "RMC", "RL", "RI", "r1Rt", "ReIC", "RMC", "SC", "mRT",
        "SCO", "SCom", "SNC", "SNCV", "SNCVL", "SNCVM", "Su3C", "SubB", "VTA", "VTAC", "VTAR",
        "RPC", "RPF", "Sag", "SNCD", "SNCM", "SNL", "SNR", "SPTg", "Su3", "SuG", "VLPAG", "VTg", "Zo"
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