From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 19 Dec 2004 16:56:20 +0000
Subject: Re: [PATCH]: sbus_free_consistent() causes oops on 2.4.28
Message-Id: <20041219165620.GT771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041219162213.GA31287@palantir8>
In-Reply-To: <20041219162213.GA31287@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 19, 2004 at 04:22:13PM +0000, Martin Habets wrote:
> Using sbus_free_consistent() on 2.4.28 causes the oops below. An rmmod
> of a module triggered that call. Porting back the 2.6 code solves the issue.

I'll send this in to marcelo, thanks.


-- wli
