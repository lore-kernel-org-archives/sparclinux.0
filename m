From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 04 Jan 2005 19:21:57 +0000
Subject: Re: [0/7] LEON SPARC V8 processor support for linux-2.6.10
Message-Id: <20050104192157.GO2708@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <41DAE87B.8030405@gaisler.com>
In-Reply-To: <41DAE87B.8030405@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:03:23PM +0100, Jiri Gaisler wrote:
> I am not sure that the pathes for serial and ethernet drivers
> should be sent to the sparclinux list. If not, please advise on
> where I should submit them.

Jeff Garzik and netdev@oss.sgi.com generally handle network drivers.

Russell King and linux-kernel@vger.kernel.org probably handle
serial drivers considered for inclusion.

I don't have a particularly organized or sophisticated plan for a
staged merging of the drivers. If either should care to absorb the
drivers instead of merely acking them, it's just as well. Both will
generally see anything going across linux-kernel.


-- wli
