# ImageJ / Fiji macros — ROI filtering by anatomical region

A set of Fiji macros to filter ROIs in the ROI Manager by anatomical name, used for cleaning up atlas-derived ROI sets on mouse brain sections exported from ABBA plugin in ImageJ/Fiji. 
Each macro keeps (or deletes) a predefined list of region acronyms covering a specific brain area.

## Repository layout
```
imagej-macros/
├── retain_ROIs_MB2.ijm              ← midbrain substructures
├── retain_ROIs_Pons2.ijm            ← pons substructures
├── retain_ROIs_Pons_MY_broad.ijm    ← pons + medulla, broad functional groups
├── retain_ROIs_Medulla.ijm          ← medulla substructures
├── retain_ROIs_Thalamus.ijm         ← thalamus substructures
├── retain_ROIs_CB.ijm               ← cerebellum substructures
├── retain_ROIs_BS.ijm               ← top-level brain divisions
```

## How the macros work

All seven macros share the same logic. Each contains a hardcoded array of ROI name acronyms (`targetROINames`). When run:
1. The macro iterates through every ROI in the ROI Manager.
2. Each ROI name is compared **case-sensitively** against the target list.
3. Depending on the `deleteSpecifiedROIs` toggle at the top of the macro:
   - `false` (default) → **retain** ROIs matching the list, delete the rest.
   - `true` → **delete** ROIs matching the list, retain the rest.
4. A summary of deleted and retained ROIs is printed to the Log window.

Matching uses a custom `caseSensitiveCompare` function — built-in string methods (`==`, `.equals`, `.contains`) gave incorrect results for short acronyms.

## Macro descriptions

### Coronal sections
**`retain_ROIs_MB2.ijm`** — Midbrain / brainstem substructures. Includes superior and inferior colliculus subdivisions (SC, DCIC, ECIC, CIC…), periaqueductal gray (DLPAG, DMPAG, LPAG, VLPAG…), raphe nuclei (DR, DRD, DRV, DRL, RLi…), substantia nigra (SNC, SNR, SNL…), VTA, cranial nerve nuclei (3N, 4N, MA3, EW…), and reticular / tegmental nuclei.

**`retain_ROIs_Pons2.ijm`** — Pons substructures (detailed). Trigeminal complex (5N, 5Tr, Pr5, Su5…), pontine reticular formation (PnO, PnC, RtTg, DTg, LDTg…), parabrachial / Kölliker–Fuse (PB, LPB, MPB, KF), locus coeruleus and noradrenergic groups (LC, A7, SubC…), raphe (MnR, PMnR, B9…), superior olivary complex and lateral lemniscus (SOC, LSO, MSO, VLL, DLL…), pontine nuclei (Pn, CGPn), and central gray subdivisions.

**`retain_ROIs_Pons_MY_broad.ijm`** — Pons + medulla, broad functional groups. Keeps only six high-level groupings: `P-sen`, `P-mot`, `P-sat`, `MY-sen`, `MY-mot`, `MY-sat` (sensory / motor / satellite). Used when working at coarse functional resolution rather than individual nuclei.

**`retain_ROIs_Medulla.ijm`** — Medulla substructures. Cranial nerve nuclei (6N, 7N, 10N, 11N, 12N, Amb, Sol…), spinal trigeminal complex (Sp5, Sp5C, Sp5I, Sp5O…), reticular formation (Gi, DPGi, LPGi, IRt, MdD, MdV…), raphe (RMg, ROb, RPa…), catecholaminergic groups (A5, C1–C3, Ad1–Ad3), vestibular and precerebellar nuclei (VeCb, IO, LRt, Bo…), and area postrema (AP).

**`retain_ROIs_Thalamus.ijm`** — Thalamus substructures. Anterior group (AD, AM, AV, AVDM…), midline / intralaminar (CM, CL, PC, Re, Rh, PVA, PVP…), mediodorsal (MD), lateral group (LD, LPMC, LPMR, LPLR, LPLC), ventral group (VA, VL, VM, VPL, VPM…), geniculate complex (LG, DLG, IGL, MG, SG…), posterior group (Po, PO, POL…), habenula (LHb, MHb), pretectal / subparafascicular (SPF, SPFP…), reticular (Rt), and subfornical organ (SFO).

**`retain_ROIs_CB.ijm`** — Cerebellum substructures. Cerebellar cortex lobules I–X with their granular-layer counterparts (`1Cb`/`1Cb-gr` … `10Cb`/`10Cb-gr`), hemispheric regions (Sim, Crus1, Crus2, Cop, PFl, Fl, PM…), vermis / hemisphere groupings (VERM, HEM, CUL), and deep cerebellar nuclei (CBN, Med, Int, Lat, DN…).

### Sagittal sections

**`retain_ROIs_BS.ijm`** — Top-level brain divisions. Keeps only the eight Allen Brain Atlas major divisions: `CB`, `MY`, `P`, `MB`, `TH`, `HY`, `CTX`, `CNU`. Designed for sagittal sections, where a single slice spans all major divisions.

## Typical workflow

Macros can be chained on the same ROI set to progressively narrow the region of interest:

1. Start by importing the ROIs overlay from a folder or ABBA and loading it into the ROI Manager.
2. Run `retain_ROIs_BS.ijm` to reduce to major divisions on sagittal sections, or a region-specific macro to keep only the area of interest for coronal sections.
3. Inspect/save the cleaned ROI set.

## Usage

### Running a macro

1. Open Fiji.
2. Load your image and ROI set into the ROI Manager.
3. Open the macro: **Plugins → Macros → Edit…** and select the `.ijm` file.
4. Click **Run** (or **Ctrl+R**).
5. Check the Log window for the summary of deleted/retained ROIs.

### Toggling retain vs delete
Edit the top of any macro:

```ijm
// false → keep listed ROIs, delete others (default)
// true  → delete listed ROIs, keep others
deleteSpecifiedROIs = false;
```

### Installing as a permanent menu item
Copy the `.ijm` file to `Fiji.app/macros/toolsets/` and restart Fiji, or use **Plugins → Macros → Install…** to load it for the current session.

## Naming conventions
Region acronyms follow standard mouse brain atlas nomenclature (Paxinos & Franklin / Allen Brain Atlas). Note that matching is **case-sensitive** — `Sol` and `SOl` will not match each other.

## Requirements
- Fiji (ImageJ 1.53 or later, tested on [add your version]).
- No additional plugins required.

## License
 MIT

## Citation
Used in the PhD project and related future article
