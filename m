From: David Miller <davem@davemloft.net>
Date: Mon, 21 May 2012 19:48:52 +0000
Subject: Re: [PATCH] net: drop NET dependency from HAVE_BPF_JIT
Message-Id: <20120521.154852.2281965083131461050.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFy4He9X6wQjATaJukzH1FkyhGqnmC4kb+azKuMmjPGbmg@mail.gmail.com>
	<20120521185202.GA6486@merkur.ravnborg.org>
	<CA+55aFwo6XusR8pNY+dp_5uFNqCxZjeWWL6h+V=PFqT884Qc_A@mail.gmail.com>
In-Reply-To: <CA+55aFwo6XusR8pNY+dp_5uFNqCxZjeWWL6h+V=PFqT884Qc_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: sam@ravnborg.org, netdev@vger.kernel.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 May 2012 11:54:00 -0700

> On Mon, May 21, 2012 at 11:52 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> Fix up all users to drop the dependency on NET now that
>> it is not required to supress warnings for non-NET builds.
> 
> Do you want me to take this directly, or will it go through the net
> tree? I can live with it either way.

Linus, please take it directly, Sam's change looks great.
