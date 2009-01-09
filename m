From: David Miller <davem@davemloft.net>
Date: Fri, 09 Jan 2009 00:59:20 +0000
Subject: Re: [PATCH v2 2/5] sparc: move EXPORT_SYMBOL to the symbols
Message-Id: <20090108.165920.114189290.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4965F1E0.1080206@gmail.com>
In-Reply-To: <4965F1E0.1080206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 08 Jan 2009 23:30:24 +1100

> From: Sam Ravnborg <sam@ravnborg.org>
> 
> sparc: move EXPORT_SYMBOL to the symbols definition
> 
> Move all applicable EXPORT_SYMBOL()s to the file where the respective
> symbol is defined.
> 
> Removed all the includes that are no longer needed in sparc_ksyms_32.c
> 
> Comment all remaining EXPORT_SYMBOL()s in sparc_ksyms_32.c
> 
> Two symbols are shared with sparc64 thus the exports were removed from
> the sparc_ksyms_64.c too, along with the include their ommission made
> redundant.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Additions by Julian Calaby:
> * Moved EXPORT_SYMBOL()s for prom functions to their rightful places.
> * Made some minor cleanups to the includes and comments of sparc_ksyms_32.c
> * Made another subtraction from sparc_ksyms_64.c
> * Updated and tidied commit message.
> * Rebased patch over sparc-2.6.git HEAD.
> * Ensured that all modified files have the correct includes.
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Applied.
