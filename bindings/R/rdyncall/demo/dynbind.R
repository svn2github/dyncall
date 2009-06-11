x <- new.env()
ls(x)

dynbind("R","

R_chk_calloc(ii)p;
R_chk_free(p)v;

", env=x)

ls(x)

