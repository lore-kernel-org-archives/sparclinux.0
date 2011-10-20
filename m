From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 20 Oct 2011 06:59:15 +0000
Subject: Re: [PATCH 3/4] sparc32: return destination pointer on return from
Message-Id: <4E9FC6C3.7040905@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1318489205-315-4-git-send-email-konrad@gaisler.com>
In-Reply-To: <1318489205-315-4-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Kjetil Oftedal <oftedal@gmail.com>
> Date: Wed, 19 Oct 2011 23:11:29 +0200 (CEST)
> 
>> On Wed, 19 Oct 2011, David Miller wrote:
>>
>>> From: Konrad Eisele <konrad@gaisler.com>
>>> Date: Wed, 19 Oct 2011 10:33:25 +0200
>>>
>>>> It seems to me that memcpy is tightly programmed. Is saving 2 lines of gdbstub.c
>>>> diff worth a memcpy rewrite?
>>>
>>> You really can't find another register to save the initial %o0 value in?
>>> Have you even tried?
>>
>> This might be considered a ugly hack. But what about using %y ? According 
>> to the V8 manual, %y might be destroyed across a procedure call, and none 
>> of the functions in memcpy.S use multiply/divide instructions. It is 
>> however not mentioned as a available register in the section dealing with 
>> leaf procedures. 
>>
>> A quick test on a SS20 did not reveal any immediate side-effects, and 
>> the return value of memcpy is now the destination pointer.
> 
> Never mind, I'll work on this myself.  Trying to get you to implement
> this properly is hopeless.  Writing to and reading from the %y
> register is extremely expensive compared to a regular register.
> 
> 

Sorry to make you angry but, yes, I looked weather all registers are taken,
and yes, memcpy is very compact programmed. The %g6 patch was a mistake, sorry.
-- Konrad
