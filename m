From: David Miller <davem@davemloft.net>
Date: Fri, 16 Jan 2015 00:14:32 +0000
Subject: Re: [PATCH v2 10/10] PCI, sparc: clip firmware assigned resource under parent bridge's
Message-Id: <20150115.191432.1173958067874072654.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1421296297-6371-1-git-send-email-yinghai@kernel.org>
	<1421296297-6371-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1421296297-6371-11-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: yinghai@kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, wangyijing@huawei.com, sam@ravnborg.org, sparclinux@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 14 Jan 2015 20:31:37 -0800

> Some bios put range that is not fully coverred by root bus resources.
> Try to clip them and update them in pci bridge bars.
>=20
> We'd like to fix other arches instead of just x86.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
> Reported-by: Marek Kordik <kordikmarek@gmail.com>
> Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to=
 64-bit resources")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
