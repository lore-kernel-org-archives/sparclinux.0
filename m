From: David Miller <davem@davemloft.net>
Date: Fri, 26 Apr 2019 05:16:20 +0000
Subject: Re: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
Message-Id: <20190426.011620.305509836638141511.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
        <CAK7LNAQL0GFHRkYmvTT=Oa8PPkF0FBdgUK_BUQvjwrwNRBEBnQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQL0GFHRkYmvTT=Oa8PPkF0FBdgUK_BUQvjwrwNRBEBnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yamada.masahiro@socionext.com
Cc: sparclinux@vger.kernel.org, ndesaulniers@google.com, linux-kernel@vger.kernel.org, frowand.list@gmail.com, mingo@kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 26 Apr 2019 09:40:46 +0900

> Hi David,
> 
> 
> On Wed, Apr 3, 2019 at 5:34 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> $(call if_changed,...) must have FORCE as a prerequisite.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
> 
> Ping?

Sorry, I'm really busy and taking a short vacation before the LSF/MM
summit.

I will get to this when I have a chance.

Thank you.
