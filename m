From: David Miller <davem@davemloft.net>
Date: Mon, 28 Aug 2017 22:49:05 +0000
Subject: Re: [PATCH] sparc: leon: grpci1: constify of_device_id
Message-Id: <20170828.154905.771431778711401050.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cde41ec4bb81718be389f0c47d0469fb2a0d27c1.1503746607.git.arvind.yadav.cs@gmail.com>
        <47b2967d191cb0b0a525682feb7991742df333e6.1503746607.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <47b2967d191cb0b0a525682feb7991742df333e6.1503746607.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arvind.yadav.cs@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Sat, 26 Aug 2017 16:58:48 +0530

> of_device_id are not supposed to change at runtime. All functions
> working with of_device_id provided by <linux/of.h> work with const
> of_device_ids. So mark the const and __initconst.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied.
