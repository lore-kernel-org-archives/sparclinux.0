From: David Miller <davem@davemloft.net>
Date: Tue, 04 Aug 2009 13:08:36 +0000
Subject: Re: Is it a bug in etrap.S srmmu stack check routine?
Message-Id: <20090804.060836.04491997.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <d543c060908031036k66ebd6a5h5285dabf3f5aefe3@mail.gmail.com>
In-Reply-To: <d543c060908031036k66ebd6a5h5285dabf3f5aefe3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eldar Abusalimov <eldar.abusalimov@gmail.com>
Date: Tue, 4 Aug 2009 17:07:32 +0400

> 2009/8/4 David Miller <davem@davemloft.net>:
>> No, a bad user stack would be if %sp >= PAGE_OFFSET, the user stack
>> must be below the lowest kernel address which is PAGE_OFFSET.
> 
> Yes, I agree, but you've just written that
> 
>>>> We want to fall through to line 288 if PAGE_OFFSET > %sp and that's
>>>> what we do.
> 
> and line 288 is trap_setup_user_stack_is_bolixed branch.

Sorry, logic reversed.
