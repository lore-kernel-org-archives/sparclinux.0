From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 27 Apr 2016 11:28:51 +0000
Subject: Re: kernel boot broken since 4.5 on t5220 ( niagara2 ) machine
Message-Id: <CADxRZqzCO5ZAqe1S5bB4Q3oiy41dnzSH-iKzAZqPeJGwENkVTg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <57207083.1000703@alcatel-lucent.com>
In-Reply-To: <57207083.1000703@alcatel-lucent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 27, 2016 at 1:09 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Apr 27, 2016 at 09:55:47AM +0200, Joerg Abraham wrote:
>> Hi,
>>
>> since kernel version 4.5 my t5220 does not boot anymore, small logs
>> attached...
>>
>> bisecting the problem points to commit:
>>
>> 1a40b95374f680625318ab61d81958e949e0afe3
>>
>> or
>>
>> 1a40b95 (sparc: Fix system call tracing register handling.)
>
> Meelis Roos reported issues with the same commit.
> See the thread "RED State Exception in 4.5 on E420R"

Just to let you know guys, I have quite a similar hardware, not T5220,
but T5120, and I don't have this issue, 4.5.x kernel works, 4.6.0
boots (but OOPS with different trace, going to report it with another
email).
