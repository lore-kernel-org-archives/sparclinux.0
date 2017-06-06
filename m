From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jun 2017 19:36:34 +0000
Subject: Re: [PATCH 14/16] sparc: vio: use dev_groups and not dev_attrs for bus_type
Message-Id: <20170606.153634.299909834402599003.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
        <20170606192221.1617-15-gregkh@linuxfoundation.org>
In-Reply-To: <20170606192221.1617-15-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue,  6 Jun 2017 21:22:19 +0200

> The dev_attrs field has long been "depreciated" and is finally being
> removed, so move the driver to use the "correct" dev_groups field
> instead for struct bus_type.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <sparclinux@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: David S. Miller <davem@davemloft.net>
