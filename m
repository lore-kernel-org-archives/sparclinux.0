From: David Miller <davem@davemloft.net>
Date: Sun, 05 May 2013 01:32:55 +0000
Subject: Re: [PATCH] serial: sunsu: add missing platform_driver_unregister() when module exit
Message-Id: <20130504.213255.347200760283293043.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAPgLHd_4TH7Ur2VWtqHD3puc9eCkfHKEP9dA-ZwnxE8MtpGLww@mail.gmail.com>
In-Reply-To: <CAPgLHd_4TH7Ur2VWtqHD3puc9eCkfHKEP9dA-ZwnxE8MtpGLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: weiyj.lk@gmail.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sat, 27 Apr 2013 18:13:16 +0800

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> We have registered platform driver when module init, and
> need unregister it when module exit.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.
