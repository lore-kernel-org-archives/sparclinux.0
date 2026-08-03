Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B90387348;
	Mon,  3 Aug 2026 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766278; cv=none; b=gPJWHaR0A/hHE4G0751rmWyEjrBf8Y9CqgfobustTgHeBqtL6rJAFp3Bs+8Zg9nXPetWCsOoTs2P50OMDIHZrE1u3VcOJN6uCxbRRgapd2vIS3ND6WjuOVYYZCUxgPiTDYk5GIe91Wa/q4OpFILG6G3M409i3xm8vLnME/7o5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766278; c=relaxed/simple;
	bh=ygFemkZsh3gGFHFacWVTYkrdvBQE72hvGXIpmD2Q5JE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OioAnOLZ+YtBoZMC6gjT/Yhz32D3V1GVnQ4+ijmXT7iaKUVeghT0zTO9m2gsxkp8kRUkh7r4RY76prNafHzFTqUrR1VpZST2G3nAxY+8W3O3yEy0g9Ohv5EyfAJT5MrMfB3DmYBo7NTiy6NnINqzwPHPH2nz9hL9TYPG0zCJKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aHrsEC2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aHrsEC2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95491F000E9;
	Mon,  3 Aug 2026 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785766276;
	bh=//qHTmaSn8Nz4JQPuBMKXuwZW1mJZmOZGK5gPlgNB2g=;
	h=From:Subject:Date:To:Cc;
	b=aHrsEC2OK3D1Ny1dDOxyJyqRQX3fjOINY/rcp+zlatefub8zdSo2EY4sDtv8crEEu
	 MlvaN5ljB9ADnVYDnDMmjnDQZqKNQ7pp7y/7/a5JWUmSFBDD1edD0BFydukd7cYl5s
	 YIG9wFMUuWvBWCngkitFa0y1uSvjO14GiJggn8fE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/2] tty: vcc: Some small vcc bugfixes found by code
 scans
Date: Mon, 03 Aug 2026 16:10:53 +0200
Message-Id: <20260803-aisle-tty-vcc-v2-0-a50bc9b15193@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOQQ6DIBREr2JY9zdCE4pd9R6NC8SP/sZAA0g0x
 rsX7brLl8y8mY1FDISRPaqNBcwUybsC4lIxM2o3IFBfmIlayPp+46ApTggprZCNAYW60QaFtNK
 y0vkEtLScvlf74zh3bzTpkByJkWLyYT0HMz9y/9yZQw2NFMhVh53S6jmRmxfrZ9frVH5efRhYu
 +/7F6AMOy/GAAAA
X-Change-ID: 20260731-aisle-tty-vcc-8ea9ace26f6f
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Joshua Rogers <linux@joshua.hu>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=ygFemkZsh3gGFHFacWVTYkrdvBQE72hvGXIpmD2Q5JE=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkFC0vOLn+4ZVW8BWPJXHNT2aXcPuv2XtTZWfn4ue+On
 OPLvjOt64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJcExhWLCs/meisr7Uyx1z
 9vqLFy16ZMvk/oVhnoX6R/+/5658FXzUyCFkbijM85ZHEwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Joshua at AISLE has been kind enough to run a bunch of scans on the
tty/serial code and here are two minor fixes for the vcc code that the
tools found.

One note, is this code even used anymore?  Seems to be sparc-specific,
just wanted to know if this platform is still alive?  If not, I'll be
glad to delete this file :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Changes in v2:
- change to use scoped_guard() in patch 2
- Link to v1: https://patch.msgid.link/20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org

---
Joshua Rogers (2):
      tty: vcc: zero-initialize control packet in vcc_send_ctl()
      tty: vcc: hold port lock when clearing tty pointer in vcc_cleanup

 drivers/tty/vcc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260731-aisle-tty-vcc-8ea9ace26f6f

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>

