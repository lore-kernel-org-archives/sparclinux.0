From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 14 Feb 2005 23:30:35 +0000
Subject: Re: TUNSETIFF: data not copied back to userspace
Message-Id: <20050214153035.1a5c85cc.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 15 Feb 2005 00:18:08 +0100 (CET)
Michael Tautschnig <michael.tautschnig@zt-consulting.com> wrote:

> So the preferred behaviour would be: Add an interface-specification to 
> l2tpns' config - or will the above "patch" ever be included in the 
> official kernel?

I put the patch into my tree just now, I'll push it upstream.
