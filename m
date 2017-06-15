From: David Miller <davem@davemloft.net>
Date: Thu, 15 Jun 2017 18:41:09 +0000
Subject: Re: [PATCH] sparc/time: make of_device_ids const
Message-Id: <20170615.144109.1575148153383203041.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <576039c52d8aebbc40bec5ea2929d6517b9130c4.1497521695.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <576039c52d8aebbc40bec5ea2929d6517b9130c4.1497521695.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arvind.yadav.cs@gmail.com
Cc: john.stultz@linaro.org, nicstange@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 15 Jun 2017 16:30:20 +0530

> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied.
