From: David Miller <davem@davemloft.net>
Date: Tue, 17 Mar 2020 00:48:36 +0000
Subject: Re: [PATCH v2 1/2] sparc: revive __HAVE_ARCH_STRLEN for 32bit sparc
Message-Id: <20200316.174836.1008034012256551916.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200311223725.27662-1-masahiroy@kernel.org>
In-Reply-To: <20200311223725.27662-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org, sparclinux@vger.kernel.org, clang-built-linux@googlegroups.com, viro@zeniv.linux.org.uk, ndesaulniers@google.com, ilie.halip@gmail.com, natechancellor@gmail.com, linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 12 Mar 2020 07:37:24 +0900

> Prior to commit 70a6fcf3283a ("[sparc] unify 32bit and 64bit string.h"),
> __HAVE_ARCH_STRLEN was defined in both of string_32.h and string_64.h
> 
> It did not unify __HAVE_ARCH_STRLEN, but deleted it from string_32.h
> 
> This issue was reported by the kbuild test robot in the trial of
> forcible linking of $(lib-y) to vmlinux.
> 
> Fixes: 70a6fcf3283a ("[sparc] unify 32bit and 64bit string.h")
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
