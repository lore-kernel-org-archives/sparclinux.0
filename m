From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 07 Oct 2014 19:19:19 +0000
Subject: Re: [PATCH] sparc64: use COMMAND_LINE_SIZE for boot string
Message-Id: <54343CB7.9000504@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5432BE03.10405@oracle.com>
In-Reply-To: <5432BE03.10405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 10/07/2014 02:03 PM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Tue, 07 Oct 2014 13:49:37 -0500
> 
>> I never realized that, but that's really not a problem since the
>> destination will have the space. The original patch shouldn't be
>> problematic, although it may make the string longer than it practically
>> needs to be. I'll let davem make the call which version he likes better.
>> Maybe the comment in the second patch can be improved.
> 
> If you make the boot string 2048 bytes, and the firmware provides
> a string longer than 1024 bytes to SILO, it will read past the end
> of barg_buf.

Isn't it already too late by the time SILO looks at the length in
kernel_params? silo_set_bootargs() has already been called, so if
barg_buf is too small, SILO has already written past the end of it
(unless I'm missing some other bounds checking).

> So I think we still need to limit it to 1024.

I hope we never have a need for anything longer.

> In the long term, we can 'fix' SILO in some backwards compatible way.
> I think the thing to do is keep putting 1024 into bootstr_len and then
> bump the HdrS version (currently 0x0301) and make that new version
> mean "ignore bootstr_len, command line buffer is 2048 bytes".
