From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 15 Feb 2005 18:06:04 +0000
Subject: Re: fix cg14 with serial console
Message-Id: <20050215100604.420f84c4.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41FF079C.7070007@mc.net>
In-Reply-To: <41FF079C.7070007@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 6 Feb 2005 16:23:39 -0600
"Art Haas" <ahaas@airmail.net> wrote:

> On Fri, Feb 04, 2005 at 09:41:42PM -0800, David S. Miller wrote:
> > That would be a great idea.  In particular, things like
> > tree.c:prom_nodematch() should check (and return "0" when
> > error occurs).
> 
> How does this look? It compiled but is untested in a running kernel.

Looks great, patch applied.  Thanks Art.
