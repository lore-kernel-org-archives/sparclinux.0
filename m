From: "David S. Miller" <davem@redhat.com>
Date: Sat, 14 Feb 2004 05:26:38 +0000
Subject: Re: RFC: [sparc32] atomic_t is 32 bits
Message-Id: <20040213212638.4b422710.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040213052029.GD22176@foobazco.org>
In-Reply-To: <20040213052029.GD22176@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 12 Feb 2004 21:41:55 -0800
Pete Zaitcev <zaitcev@redhat.com> wrote:

> This is bigger than what I would leave inline. I have no idea
> what willy and prumpf thought when they did it this way.
> The Linux code is all infested with atomics, so there may be savings.
> Your call though.
> 
> The rest looks great.

I am going to apply this now to 2.6.x, but we should uninline some of this
stuff afterwards as I agree with Peter.
