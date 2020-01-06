From: David Miller <davem@redhat.com>
Date: Mon, 06 Jan 2020 21:33:36 +0000
Subject: Re: [PATCH] modpost: assume STT_SPARC_REGISTER is defined
Message-Id: <20200106.133336.719905028750983361.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200104153651.2258-1-masahiroy@kernel.org>
In-Reply-To: <20200104153651.2258-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org, sparclinux@vger.kernel.org, arnd@arndb.de, bcollins@debian.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun,  5 Jan 2020 00:36:51 +0900

> Commit 8d5290149ee1 ("[SPARC]: Deal with glibc changing macro names in
> modpost.c") was more than 14 years ago. STT_SPARC_REGISTER is hopefully
> defined in elf.h of recent C libraries.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
