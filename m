From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jun 2019 21:12:57 +0000
Subject: Re: [PATCH] sparc: configs: Remove useless UEVENT_HELPER_PATH
Message-Id: <20190613.141257.353333294023050596.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1559635259-21585-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635259-21585-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: krzk@kernel.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, geert+renesas@glider.be

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue,  4 Jun 2019 10:00:59 +0200

> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.
