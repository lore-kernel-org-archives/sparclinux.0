From: Nick Krause <xerofoify@gmail.com>
Date: Fri, 18 Jul 2014 17:20:40 +0000
Subject: Re: Sparc Allmodconfig Fails
Message-Id: <CAPDOMVhq969+pCRZckat9RW3m44RMG0mHzyUuPJzvGBHhW-1Qw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAPDOMViDWF93xDQ=OYWFEu=9ih6cwcEKv4P+nOihcnRrDXiAww@mail.gmail.com>
	<20140718074143.GB20028@ravnborg.org>
In-Reply-To: <20140718074143.GB20028@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 18, 2014 at 3:41 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Jul 18, 2014 at 12:21:04AM -0400, Nick Krause wrote:
>> The build for sparc allmodconfig is still failing for the main branch
>> of the linux kernel.
>> I would recommend fixing these issues. I am attaching my build
>> warnings and errors
>> logs for the failing build test I did today.
>
> Did you actually look into the log yourself?
>
> This should give you a hint:
>
> make[1]: *** No rule to make target `/media/nick/Nick's', needed by
> +`kernel/x509_certificate_list'.  Stop.
>
>
> All the rest are random warnings that may or may not be specific for sparc64.
>
>         Sam

I did , needs this issue is on my computer. I thought that this was a common
error. Therefore it seems it builds correctly now if we exclude my build error.
Cheers Nick
