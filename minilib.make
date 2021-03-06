#mlconfig
ifdef undef
#
# type 'make -f minilib.make'
# to use this combined config and makefile generated by mini-gcc,
# compile and download when needed (ca.100kB) with minilib.
# (https://github.com/michael105/minilib)
#
# Alternatively, when the script mini-gcc with the embedded minilib is already present,
# 'mini-gcc --config minilib.make' 
# compiles without fetching minilib again.
#
# 
# Minilib and the accompanying tools are licensed under a 
# BSD-style opensource license with attribution.
# I did my best and I'm using minilib myself,
# but cannot give any guarantees for any functionality
# of the opensourced library or the accompanying tools.
#
# (Disclaimer)
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Michael Myer BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The full license is available at the webpage of minilib.
# https://github.com/michael105/minilib
# Michael (misc) Myer, 2021
#



# config generated by mini-gcc.
# Save default. The minibuf is needed for malloc, printf, and file streams.
mini_buf 4096

# define headerguards, to prevent parsing the standard header
HEADERGUARDS

# Startup function
mini_start

# Build minilib source
INCLUDESRC

LDSCRIPT default

#shrinkelf

# function switches. Only functions named below will be compiled
COMPILE close dup2 fprintf itodec fputc free fstat lseek malloc memcmp memcpy\
	open read rename strcpy strlen unlink write errno exit itodec

# list of source files, supplied to gcc
SOURCES shrinkelf.c

# the binary to be compiled ( -o $BINARY )
BINARY shrinkelf


return
endif
# configuration part ends, 
# embedded makefile starts below

# the version of minilib to download
MINILIB_VERSION := "20210629"
urlbase := "https://raw.githubusercontent.com/michael105/minilib/download"

fetch = $(shell ((curl $(urlbase)/$(MINILIB_VERSION)/$(1).gz > $(1).gz) || (wget $(urlbase)/$(MINILIB_VERSION)/$(1).gz)) && gunzip $(1).gz)


default: Makefile.minilib minilib.h check compile


compile:
	$(info Compile)
	make -f Makefile.minilib CONF="$(lastword $(MAKEFILE_LIST))"


Makefile.minilib:
	$(info "Download Makefile.minilib (Version $(VERSION))from github")
	$(call fetch,Makefile.minilib)


minilib.h:
	$(info "Download minilib.h (Version $(VERSION))from github")
	$(call fetch,minilib.h)


.ONESHELL:
check:
	@echo "Checking sha256 sums"
	echo -e "$(SHA256SUMS)" | sha256sum -c || exit
	echo ok 


# checksums 
define SHA256SUMS =
e7871196b083f725cfe6d8c4a3f84d4ad1e3c246495ad9c7e870e24f22b5b37c  minilib.h
a0f1cc92cc34fd55a500213069fcef2eda96006a71ef950c2a2744bd8fba6149  Makefile.minilib
endef




