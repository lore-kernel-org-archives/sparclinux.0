From: "Jan Beulich" <jbeulich@novell.com>
Date: Tue, 06 Jan 2009 12:39:35 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <49635F17.76E4.0078.0@novell.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org>
 <20090105194844.GR28946@ZenIV.linux.org.uk>
 <20090105195523.GB6204@uranus.ravnborg.org>
 <49631BF0.76E4.0078.0@novell.com>
 <20090106113543.GS28946@ZenIV.linux.org.uk>
In-Reply-To: <20090106113543.GS28946@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>, rostedt@goodmis.org, Steven Rostedt <srostedt@redhat.com>, LKML <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

>>> Al Viro <viro@ZenIV.linux.org.uk> 06.01.09 12:35 >>>
>On Tue, Jan 06, 2009 at 07:53:04AM +0000, Jan Beulich wrote:
>> The others look like a tools side behavioral difference, as I never saw any
>> such. Is this problem sparc32-specific (I tested x86 and ia64 only)? What's
>> the binutils version used?
>
>2.18.50.0.6.
>
>And no, it's not tools side.  What it is, AFAICT, is that sparc32 has
>LDFLAGS_vmlinux = -r, which leaves a metric arseload of relocs that
>wouldn't have survived into vmlinux otherwise.  Look at .rela__ksymtab
>in .tmp_vmlinux1, for example...

That I think can only be taken care of by disallowing the stripping for that
arch, i.e. adding a negative dependency to the Kconfig option. Or can
anyone think of any other solution?

Jan

