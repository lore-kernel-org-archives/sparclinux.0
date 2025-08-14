Received: from mail.polzysk.pl (mail.polzysk.pl [51.195.117.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00D2DF68
	for <sparclinux@vger.kernel.org>; Thu, 14 Aug 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.195.117.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158185; cv=none; b=PKIPBtHZEzVSK3Qn2gJWgYo7MjHM3uqguK7QLFTJD3wlSZcRAJWLB0Va5VItD0dFy1eBEmMb6ZcGfoLSUCOpv3T6NmPlsJ1QncpbkiUq4VFh5fwv9n5Bu8lhRmhIBSzbRyFOdnp7ePwn4PzkSLpn4PBvyJpMcA5zY0pVuGn82OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158185; c=relaxed/simple;
	bh=96m+050cLjqDQRkC/1CgIMt/03Lo2MZ7ONpaxXbBU8s=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=kDK0eN2Ez7e4XRTl/wQpk1cstKO7ovi7vAHtPOIFtdK8Te3ItWQXvWwHOWO6frVdEjEsvVLpQK67ratce5SRi3u/3uV1dMYnfOHxLMy90ODIO8Xh5qfgOKQkKbqWn+ugx1VRGd/PpcWI8zx5/2/Dn/pxY5+F0vn64i80FOzyvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=polzysk.pl; spf=pass smtp.mailfrom=polzysk.pl; dkim=pass (2048-bit key) header.d=polzysk.pl header.i=@polzysk.pl header.b=R4X2TUtV; arc=none smtp.client-ip=51.195.117.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=polzysk.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polzysk.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=polzysk.pl header.i=@polzysk.pl header.b="R4X2TUtV"
Received: by mail.polzysk.pl (Postfix, from userid 1002)
	id 10937A4CB3; Thu, 14 Aug 2025 09:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=polzysk.pl; s=mail;
	t=1755157573; bh=96m+050cLjqDQRkC/1CgIMt/03Lo2MZ7ONpaxXbBU8s=;
	h=Date:From:To:Subject:From;
	b=R4X2TUtVn1nrnSJyTFpI9lsTee+eYNmqdQZ/tWJ3Rv+AMR/uaQ/nFutU4h+P2X1Ds
	 fIApUXWRxtJixhHzKORzeq1zDwRFAckRxkK0uk55xNFtiWcqJdminZ96DyA0JO1N80
	 W1lWspNyOw/XW1ALHp/UvZxr93ycCvwg1iVT5rNXBiMrmYJ8J4jBVODrlmPYATGiYR
	 nPsAu5Yo+fKSRURIbOD0HxcfTX0ZaXnpSNRK6TjugMaZvC+244LofZNX9IIfaHXZm0
	 ppYe2B/C0A4PJa3qIZSvLooeeHrIB+0E8dyHCgw6edYzbMJov1Fehz4yU+TIplmxiq
	 lPm6vEd5oTFEw==
Received: by mail.polzysk.pl for <sparclinux@vger.kernel.org>; Thu, 14 Aug 2025 07:46:06 GMT
Message-ID: <20250814084500-0.1.oe.35hj6.0.q98j05mx3p@polzysk.pl>
Date: Thu, 14 Aug 2025 07:46:06 GMT
From: "Piotr Skowronek" <piotr.skowronek@polzysk.pl>
To: <sparclinux@vger.kernel.org>
Subject: Energia elektryczna - zmiany
X-Mailer: mail.polzysk.pl
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

czy mogliby=C5=9Bmy um=C3=B3wi=C4=87 si=C4=99 na kr=C3=B3tk=C4=85 rozmow=C4=
=99 na temat zmiany obecnego dostawcy energii?

Udost=C4=99pniamy najkorzystniejsze na rynku warunki na stabilne dostawy =
energii elektrycznej.

Czy mog=C4=99 niezobowi=C4=85zuj=C4=85co przedstawi=C4=87 propozycj=C4=99=
?


Pozdrawiam
Piotr Skowronek
