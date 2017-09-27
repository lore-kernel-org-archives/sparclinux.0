From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 27 Sep 2017 19:59:22 +0000
Subject: Re: [PATCH v2 1/2] sparc64: Define SPARC default fls and __fls
Message-Id: <20170927195922.GA22664@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1506540326-9604-1-git-send-email-vijay.ac.kumar@oracle.com>
 <1506540326-9604-2-git-send-email-vijay.ac.kumar@oracle.com>
 <20170927195043.GA15193@ravnborg.org>
In-Reply-To: <20170927195043.GA15193@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vijay Kumar <vijay.ac.kumar@oracle.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com

> > +
> > +EXPORT_SYMBOL(__fls)
> > +EXPORT_SYMBOL(fls)
> > +
> > +fls:
> Use ENTRY(), ENDPROC() for assembler functions.
And locate EXPORT_SYMBOL() right after ENDPROC().

	Sam
