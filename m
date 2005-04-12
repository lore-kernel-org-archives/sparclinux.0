From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 12 Apr 2005 19:19:16 +0000
Subject: Re: SMP on virtually indexed/tagged cache
Message-Id: <20050412121916.73d981df.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <737167738@web.de>
In-Reply-To: <737167738@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 12 Apr 2005 14:50:54 +0200
"Konrad Eisele" <eiselekd@web.de> wrote:

> I trying to get sparc32-smp run on a Leon3 sparc,
> it uses a  virtually indexed/tagged cache. Is it possible
> to run smp on such a processor?

Yes, it's just painful.  Model your cache flushing on the
sun4c code.
