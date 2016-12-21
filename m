From: David Miller <davem@davemloft.net>
Date: Wed, 21 Dec 2016 19:06:16 +0000
Subject: Re: [PATCH] sparc64: shut down to OBP correctly
Message-Id: <20161221.140616.759641030462171211.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1482340333-65764-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1482340333-65764-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed, 21 Dec 2016 10:51:33 -0800

> On 21 Dec 16 13:07, David Miller wrote:
>> From: Larry Bassel <larry.bassel@oracle.com>
>> Date: Wed, 21 Dec 2016 09:12:13 -0800
>> 
>> > Orabug: 24789774
>> > 
>> > The command "shutdown -h -H now" should shut down the system to
>> > OBP, however the machine was incorrectly being powered off instead
>> > (on both LDOM and bare metal).
>> > 
>> > The "exit" command to the OBP must be run and then a hard
>> > loop to prevent return to the kernel.
>> > 
>> > Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
>> 
>> On LDOM, once you boot past the early stages of the kernel, OBP is
>> considered volatile and thus unusable.
> 
> My code does work on an 4.9.0 LDOM (we get to the ok prompt). So you're saying
> this was a "lucky accident" and there is no "clean" way of getting back to
> the OBP when we are in a LDOM (i.e. all we can do is power off which is
> what the current code does)?

Yes, for a very long time the firmware/hypervisor engineers told me
exactly this.

> Unfortunately, the variable "ldom_domaining_enabled" is 1 even when
> we are not in an LDOM (I just double checked this by printing
> the value out as we shut down) and so the current code will power off in
> the bare metal case as well. Is there is a good way of determining that
> we are running on bare metal?

Even for bare metal the condition holds.  As long as we use the interfaces
guarded by ldom_domaining_enabled, the OBP is not reliably available after
early boot.
