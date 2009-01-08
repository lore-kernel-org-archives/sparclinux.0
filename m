From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 08 Jan 2009 13:59:46 +0000
Subject: Re: [PATCH v3 1/5] sparc: Create a new file lib/ksyms.c and add export of all symbols defined in ass
Message-Id: <20090108140114.GA17415@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4965FC70.9010609@gmail.com>
In-Reply-To: <4965FC70.9010609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 09, 2009 at 12:15:28AM +1100, Julian Calaby wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
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
> ---
> 
> This is to replace version 2 of this patch as it failed a allmodconfig build.

I will give this one and the rest some testing tonight and let you know.

	Sam
