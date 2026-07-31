Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FB3B2FE9;
	Fri, 31 Jul 2026 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485740; cv=none; b=nDdjl6mD63CM8pX7+ZJa7e4ZwI7oMTX27dvVyBqxbtN/RW+hWM0YMsU2al6sHM3dmljSHR/asfDXZyYqp9I6IYBcb2bEjIKhm2bAm960m+k/gnpN0430mZvLxCoVlixfSPX8YmiCG3/L0OQVhtXv45h3e/FiIM0+9xQIKFdOmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485740; c=relaxed/simple;
	bh=7TPwALCSiqEbo8KqURH0TmcP/pbyRvrP5SbFqniBTxk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y7D2yT1DHTu9nzLlRXKgNKVbznrNHn7hIl2TTC0zvhMrhcMpR2oK7IF323i+mlQJriQLlSvhxJoV+ht46XsRL2gEHrDJJIkC/W/7Qym+axfvTwtk/KDyINW5EK4ZXORlc1phYB2wVORQwd1p/jg8f5Sd9S1b+gyR/Eby/TueRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CLpIyPBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CLpIyPBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE421F00A3E;
	Fri, 31 Jul 2026 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785485732;
	bh=zwFfFSYsJERK4Ru5nsMwNro02MXDMSx/ElSoheRkC4I=;
	h=From:Subject:Date:To:Cc;
	b=CLpIyPBea2CKZAqLaMRX3gdt/yhrCBuDACMPytpkoJcMLLKPyLA6XeiaZJr5C1Haa
	 N9bvn5k8ls+ElufO5OHK2P4zceSCTscPA/soymkBv3VQv/+f23m0y3S0pyxpviuLwO
	 QyWxYRPxnbtPVdYnR8WuCLC1M/uSJqevWj4Gi+TQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] tty: vcc: Some small vcc bugfixes found by code scans
Date: Fri, 31 Jul 2026 10:15:16 +0200
Message-Id: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJlKSiVzEuyvBXxhg0nUIwh
 Ltbdfkt3tvIkBRG52qjhEVNn1NBc6hIxjDdwDoUk6udr49tw0HtAc75zYsIdwinIHA++kileSV
 EXX+/y/Vvm/s7JH8ntO8fFTgvbnEAAAA=
X-Change-ID: 20260731-aisle-tty-vcc-8ea9ace26f6f
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Joshua Rogers <linux@joshua.hu>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=820;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=7TPwALCSiqEbo8KqURH0TmcP/pbyRvrP5SbFqniBTxk=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5kdMEz+oV+E+/aKLdzO/GZfbj8BylC/85r+rcrP5SG
 u/s6nOhI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbyQZ1hQePXczbOj9cEX5dP
 qS+6MNtCrKmxi2G+d9jSTye+z3fSmGK64M8Cr5V7OZdmAgA=
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
Joshua Rogers (2):
      tty: vcc: zero-initialize control packet in vcc_send_ctl()
      tty: vcc: hold port lock when clearing tty pointer in vcc_cleanup

 drivers/tty/vcc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260731-aisle-tty-vcc-8ea9ace26f6f

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>

