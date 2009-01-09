From: David Miller <davem@davemloft.net>
Date: Fri, 09 Jan 2009 00:59:12 +0000
Subject: Re: [PATCH v3 1/5] sparc: Create a new file lib/ksyms.c and add
Message-Id: <20090108.165912.31483374.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4965FC70.9010609@gmail.com>
In-Reply-To: <4965FC70.9010609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 09 Jan 2009 00:15:28 +1100

> sparc: Create a new file lib/ksyms.c and add export of all symbols
> defined in assembler in lib/ to this file.
> 
> Remove the duplicate entries from kernel/sparc_ksyms_*.c
> 
> The rationale behind this is that the EXPORT_SYMBOL() should be close to
> their definition and we cannot add designate a symbol to be exported in
> assembler so at least put it in a file in the same directory.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Additions by Julian Calaby:
> * Rebased over sparc-2.6.git HEAD
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Applied.
