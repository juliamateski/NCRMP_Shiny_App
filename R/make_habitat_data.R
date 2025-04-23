make_habitat_data <- function(){

habitat_lookup <- data.frame(
  REGION = c("FLK", "FLK", "FLK", "FLK", "FLK", "FLK", "FLK", "FLK", "FLK",
             "Tortugas", "Tortugas", "Tortugas", "Tortugas", "Tortugas", "Tortugas", "Tortugas", "Tortugas", "Tortugas",
             "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI", "SEFCRI",
             "FGB", "FGB"),
  HABITAT_CD = c(
    "CONT_HR", "CONT_LR", "CONT_MR", "ISOL_HR", "ISOL_LR", "ISOL_MR", "RUBB_LR", "SPGR_HR", "SPGR_MR",
    "CONT_HR", "CONT_LR", "CONT_MR", "ISOL_HR", "ISOL_LR", "ISOL_MR", "RUBB_LR", "SPGR_HR", "SPGR_MR",
    "APRD", "CPDP", "CPSH", "DPRC", "LIRI", "LIRM", "LIRO", "PTCH", "RGDP", "RGSH", "SCRS", "SPGR",
    "HR", "LR"),
  HABITAT_TYPE = c(
    "Contiguous reef, non-spur-groove, high vertical relief",
    "Contiguous reef, non-spur-groove, low vertical relief",
    "Contiguous reef, non-spur-groove, moderate vertical relief",
    "Isolated, patchy reef structures, high vertical relief",
    "Isolated, patchy reef structures, low vertical relief",
    "Isolated, patchy reef structures, moderate vertical relief",
    "Reef rubble, low vertical relief",
    "Spur-groove reef, high vertical relief",
    "Spur-groove reef, moderate vertical relief",
    "Contiguous reef, non-spur-groove, high vertical relief",
    "Contiguous reef, non-spur-groove, low vertical relief",
    "Contiguous reef, non-spur-groove, moderate vertical relief",
    "Isolated, patchy reef structures, high vertical relief",
    "Isolated, patchy reef structures, low vertical relief",
    "Isolated, patchy reef structures, moderate vertical relief",
    "Reef rubble, low vertical relief",
    "Spur-groove reef, high vertical relief",
    "Spur-groove reef, moderate vertical relief",
    "Aggregated Patch Reef Deep",
    "Colonized Pavement Deep",
    "Colonized Pavement Shallow",
    "Deep Ridge Complex",
    "Linear Reef Inner",
    "Linear Reef Middle",
    "Linear Reef Outer",
    "Patch Reef",
    "Ridge Deep",
    "Ridge Shallow",
    "Scattered Coral and Rock in Sand",
    "Spur and Groove",
    "High Relief",
    "Low Relief")
)

return(habitat_lookup)

}


