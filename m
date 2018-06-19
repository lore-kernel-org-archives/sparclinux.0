From: Vinod <vkoul@kernel.org>
Date: Tue, 19 Jun 2018 04:26:12 +0000
Subject: Re: [PATCH v4 26/26] fix a series of Documentation/ broken file name references
Message-Id: <20180619041412.GL25852@vkoul-mobl>
List-Id: <sparclinux.vger.kernel.org>
References: <041e7a803fc0e5c5dfc1fb8b2f761074ca0baa2c.1529079120.git.mchehab+samsung@kernel.org>
In-Reply-To: <041e7a803fc0e5c5dfc1fb8b2f761074ca0baa2c.1529079120.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "David S. Miller" <davem@davemloft.net>, Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@zh-kernel.org, dmaengine@vger.kernel.org, platform-driver-x86@vger.kernel.org, sparclinux@vger.kernel.org, devel@lists.orangefs.org, linux-pm@vger.kernel.org

On 15-06-18, 13:30, Mauro Carvalho Chehab wrote:

>  If you have any comment or update to the content, please contact the
>  original document maintainer directly.  However, if you have a problem
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index b451354735d3..08ba8473a284 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -38,7 +38,7 @@
>   * Each device has a channels list, which runs unlocked but is never modified
>   * once the device is registered, it's just setup by the driver.
>   *
> - * See Documentation/dmaengine.txt for more details
> + * See Documentation/driver-api/dmaengine for more details

DMAengine part:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
