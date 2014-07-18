From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Jul 2014 07:41:44 +0000
Subject: Re: Sparc Allmodconfig Fails
Message-Id: <20140718074143.GB20028@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAPDOMViDWF93xDQ=OYWFEu=9ih6cwcEKv4P+nOihcnRrDXiAww@mail.gmail.com>
In-Reply-To: <CAPDOMViDWF93xDQ=OYWFEu=9ih6cwcEKv4P+nOihcnRrDXiAww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Krause <xerofoify@gmail.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 18, 2014 at 12:21:04AM -0400, Nick Krause wrote:
> The build for sparc allmodconfig is still failing for the main branch
> of the linux kernel.
> I would recommend fixing these issues. I am attaching my build
> warnings and errors
> logs for the failing build test I did today.

Did you actually look into the log yourself?

This should give you a hint:

make[1]: *** No rule to make target `/media/nick/Nick's', needed by
+`kernel/x509_certificate_list'.  Stop.


All the rest are random warnings that may or may not be specific for sparc64.

	Sam
