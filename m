From: "Jan Beulich" <jbeulich@novell.com>
Date: Tue, 06 Jan 2009 07:53:04 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <49631BF0.76E4.0078.0@novell.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org>
 <20090105194844.GR28946@ZenIV.linux.org.uk>
 <20090105195523.GB6204@uranus.ravnborg.org>
In-Reply-To: <20090105195523.GB6204@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>, rostedt@goodmis.org, Steven Rostedt <srostedt@redhat.com>, LKML <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

>On Mon, Jan 05, 2009 at 07:48:44PM +0000, Al Viro wrote:
>> On Mon, Jan 05, 2009 at 07:19:22PM +0100, Sam Ravnborg wrote:
>> > With an allmodconfig build on sparc and sparc64 I started
>> > to see warnings that become propagated to errors by -Werror.
>> 
>> While we are at it, sparc32 allmodconfig is broken by
>> commit 9bb482476c6c9d1ae033306440c51ceac93ea80c
>> Author: Jan Beulich <jbeulich@novell.com>
>> Date:   Tue Dec 16 11:30:08 2008 +0000
>> 
>>     allow stripping of generated symbols under CONFIG_KALLSYMS_ALL
>> 
>> Results in
>> sparc-linux-objcopy: not stripping symbol `__ksymtab_strings' because it is named in a relocation
>> sparc-linux-objcopy: not stripping symbol `__crc_per_cpu__softirq_work_list' because it is named in a relocation
>> sparc-linux-objcopy: not stripping symbol `__initcall_end' because it is named in a relocation
>> sparc-linux-objcopy: not stripping symbol `__setup_end' because it is named in a relocation
>> sparc-linux-objcopy: not stripping symbol `__setup_start' because it is named in a relocation
>> sparc-linux-objcopy: not stripping symbol `__initcall_start' because it is named in a relocation
>> make: *** [.tmp_vmlinux1.stripped] Error 1

The __crc_... reference is definitely bogus - none should survive with the
new .c->.o rule. Could you find out what object file they originate from?

The others look like a tools side behavioral difference, as I never saw any
such. Is this problem sparc32-specific (I tested x86 and ia64 only)? What's
the binutils version used?

Jan

