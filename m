From: David Miller <davem@davemloft.net>
Date: Fri, 09 Jan 2009 00:59:30 +0000
Subject: Re: [PATCH v2 3/5] sparc64: move EXPORT_SYMBOL to the symbols
Message-Id: <20090108.165930.207007292.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4965F1EC.6050803@gmail.com>
In-Reply-To: <4965F1EC.6050803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 08 Jan 2009 23:30:36 +1100

> sparc64: move EXPORT_SYMBOL to the symbols definition
> 
> Move all applicable EXPORT_SYMBOL()s to the file where the respective
> symbol is defined.
> 
> Removed all the includes that are no longer needed in sparc_ksyms_64.c
> 
> Comment all remaining EXPORT_SYMBOL()s in sparc_ksyms_64.c
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Additions by Julian Calaby:
> * Moved EXPORT_SYMBOL()s for prom functions to their rightful places.
> * Made some minor cleanups to the includes and comments of sparc_ksyms_64.c
> * Updated and tidied commit message.
> * Rebased patch over sparc-2.6.git HEAD.
> * Ensured that all modified files have the correct includes.
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Applied.
