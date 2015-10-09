From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 09 Oct 2015 16:19:20 +0000
Subject: Re: [PATCH v7 05/60] sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
Message-Id: <1444407560.17726.6.camel@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1444340359-8011-6-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> For device resource PREF bit setting under bridge 64-bit pref resource,
> we need to make sure only set PREF for 64bit resource, so set
> IORESOUCE_MEM_64 for 64bit resource during of device resource flags
> parsing.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org

Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com>=20




