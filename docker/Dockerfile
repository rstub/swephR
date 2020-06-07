FROM wch1/r-debug:latest

ENV _R_CHECK_FORCE_SUGGESTS_=false

RUN git clone https://github.com/rstub/swephR \
 && RD CMD build swephR --no-build-vignettes

RUN RDvalgrind -d valgrind CMD check --ignore-vignettes --no-manual swephR*.tar.gz \
 && RDsan  CMD check --ignore-vignettes --no-manual swephR*.tar.gz \
 && RDcsan  CMD check --ignore-vignettes --no-manual swephR*.tar.gz
