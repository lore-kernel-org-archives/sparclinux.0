From: David Miller <davem@davemloft.net>
Date: Fri, 13 Apr 2007 20:48:01 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070413.134801.99727441.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 13 Apr 2007 15:18:59 -0500

> Tried the new esp driver on an SparcStation 4, with not much luck.
> 
> If you are willing to tackle this, and want esp_debug, please let me
> know.

Thanks, this dump should be good enough for now, I think I'm
not programming the DMA properly on older ESP/DMA chips.
