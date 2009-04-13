From: Mark Farnell <mark.farnell@gmail.com>
Date: Mon, 13 Apr 2009 10:05:30 +0000
Subject: Re: getting the program counter from sparc64 under gcc/glibc linux
Message-Id: <aaf549e0904130305m43fb41a7q25652c39edd41b82@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <aaf549e0904111624s386eb6dfm1401a5561dfdc2f1@mail.gmail.com>
In-Reply-To: <aaf549e0904111624s386eb6dfm1401a5561dfdc2f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks!  I have just hot it working.


On Mon, Apr 13, 2009 at 2:54 PM, David Miller <davem@davemloft.net> wrote:
> From: Mark Farnell <mark.farnell@gmail.com>
> Date: Mon, 13 Apr 2009 09:32:33 +1200
>
>> I am a bit confused here.
>>
>> The signal handler will be:
>>
>> void (*sa_sigaction)(int, siginfo_t *, void *);
>>
>> in your last email, do you mean that I should cast the last argument
>> to sigcontext_t rather than ucontext_t?
>
> That's correct.
>
>
