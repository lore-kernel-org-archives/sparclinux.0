From: Eldar Abusalimov <eldar.abusalimov@gmail.com>
Date: Tue, 04 Aug 2009 13:07:32 +0000
Subject: Re: Is it a bug in etrap.S srmmu stack check routine?
Message-Id: <d543c060908040607x376cd20du9a65c40a84422943@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <d543c060908031036k66ebd6a5h5285dabf3f5aefe3@mail.gmail.com>
In-Reply-To: <d543c060908031036k66ebd6a5h5285dabf3f5aefe3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2009/8/4 David Miller <davem@davemloft.net>:
> No, a bad user stack would be if %sp >= PAGE_OFFSET, the user stack
> must be below the lowest kernel address which is PAGE_OFFSET.

Yes, I agree, but you've just written that

>>> We want to fall through to line 288 if PAGE_OFFSET > %sp and that's
>>> what we do.

and line 288 is trap_setup_user_stack_is_bolixed branch.

-- 
Best regards,
Eldar Sh. Abusalimov
