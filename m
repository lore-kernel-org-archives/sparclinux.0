From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jul 2017 09:53:52 +0000
Subject: Re: [PATCH] sparc: kernel: pmc: make of_device_ids const.
Message-Id: <20170703.025352.1327035307612754913.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a582a2096ae42e6d2411ce1323e25b7c55181517.1498551384.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <a582a2096ae42e6d2411ce1323e25b7c55181517.1498551384.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arvind.yadav.cs@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 27 Jun 2017 14:39:58 +0530

> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied.
