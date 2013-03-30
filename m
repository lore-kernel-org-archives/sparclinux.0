From: David Miller <davem@davemloft.net>
Date: Sat, 30 Mar 2013 22:02:47 +0000
Subject: Re: [PATCH 4/5] sparc: use asm-generic version of types.h
Message-Id: <20130330.180247.1020276714500489604.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364679866-29982-4-git-send-email-sam@ravnborg.org>
In-Reply-To: <1364679866-29982-4-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 22:44:25 +0100

> We failed to include the header file that define __u16 because __sparc__
> was not defined.

Is this another problem with your cross compiler?

__sparc__ should always be defined, it's a CPP pre-define.
