From: David Miller <davem@davemloft.net>
Date: Wed, 09 Mar 2011 20:54:56 +0000
Subject: Re: [PATCH 3/5] sparc: Fix .size directive for do_int_load
Message-Id: <20110309.125456.39185219.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1299630719.4146.24.camel@localhost>
In-Reply-To: <1299630719.4146.24.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 09 Mar 2011 00:31:59 +0000

> gas used to accept (and ignore?) .size directives which referred to
> undefined symbols, as this does.  In binutils 2.21 these are treated
> as errors.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied, thanks Ben.
