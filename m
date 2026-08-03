Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922240F759;
	Mon,  3 Aug 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766283; cv=none; b=WlFSnHr4Dv7tJI+yZt/+qcVxarHOPN6c907RcjG1+gXP73aZ+174Se/eGiGDMEv8D5hv6veUrow+dWlC3+eCrMJ1H40vLbfaXrGjxz701v1CN2eT9ptA12uhRWHc3hpRm723B0WL+N8/eu84suT4cIAQUgQUf91T1ZEQW68E900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766283; c=relaxed/simple;
	bh=qod1kldoxOL4+StIyobWsZtCVUU/S3T7yDLmBcNpBOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AywnUhsjYqFazj506dV2OTW/4STgRclIcUmEdKN6kZ+l8xdnQFEhhv1bWliIhSXUbaOPXp4Q9SN/kYcHOvsNKaeQ7AIH6izvbO4Tml7VVS3f9ahBrhz4/2HFX9HU8bV4lMvUiunGj6RjnMe/9ltBM+Tc7KobNya3ULCucwYlaSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=njgpQfib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="njgpQfib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5301F00A3A;
	Mon,  3 Aug 2026 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785766282;
	bh=0JEtF4uhZ/xwqVHWOd87FJU1a4CIL2n7CzuY18k0BfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=njgpQfib+6SOvkKJY8eouYVz7qRt0TES8tlpXi8SRtxZusbLr+WPzwlNQ+6wN4+sj
	 Y4bFvR1dYC5mdxD6UpMIUAWV0h1yg7dNoR2xdNWr6dB6zgRF9q8uL0Z9CgOLeIqMOq
	 olr6SnvaG6QhfWdq9LrYY9lqBVBwhqNAZe3ZYI7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 03 Aug 2026 16:10:55 +0200
Subject: [PATCH v2 2/2] tty: vcc: hold port lock when clearing tty pointer
 in vcc_cleanup
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-aisle-tty-vcc-v2-2-a50bc9b15193@linuxfoundation.org>
References: <20260803-aisle-tty-vcc-v2-0-a50bc9b15193@linuxfoundation.org>
In-Reply-To: <20260803-aisle-tty-vcc-v2-0-a50bc9b15193@linuxfoundation.org>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Joshua Rogers <linux@joshua.hu>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=QJHFkLZlhHMGzuovuFDTu96rwVxMxfuLPI79nitom9w=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkFC0sOJwTf2rRvy2oZ0aXPGRj36q2v5IjZnnulUaR24
 a9fJ6XvdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBE9NcyLNi3iYkv73ZhqPqC
 rApno4ns828KuzAsWCQXI1E698T5AAXd5YmeuhsOya6ZDwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

vcc_cleanup() sets port->tty to NULL without holding port->lock, racing
with vcc_event() LDC callbacks that read port->tty under port->lock and
then use tty->port. This can cause a use-after-free when the callback
dereferences tty->port after cleanup has already destroyed and freed it.

Assisted-by: AISLE:Snapshot
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vcc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 3947bd2b75ac..9adb533f7034 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -986,7 +986,8 @@ static void vcc_cleanup(struct tty_struct *tty)
 
 	port = vcc_get(tty->index, true);
 	if (port) {
-		port->tty = NULL;
+		scoped_guard(spinlock_irqsave, &port->lock)
+			port->tty = NULL;
 
 		if (port->removed) {
 			vcc_table_remove(tty->index);

-- 
2.55.0

