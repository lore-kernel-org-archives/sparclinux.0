Received: from mail.profitiq.pl (mail.profitiq.pl [217.61.97.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A11A3158
	for <sparclinux@vger.kernel.org>; Fri, 28 Feb 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=217.61.97.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734328; cv=pass; b=HWbEmQlc8XZjAYKymeELMclHbB51QcIgYUCGGlPkuwqDjRblYf5tY0TkfSnjgJ/Avwu1qZ6gHI+BmM06x6lTK/QIvoeUwCN1g9sK7oLhylJXygllPaPZC9LRP2FyrQSKh4ax/PM0ULJQpULBfk5cy4KSzZV4jaimoQf30ou3YFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734328; c=relaxed/simple;
	bh=e8QY90WF0s922aqFGIlQWUD16N2CFUeuI5eM65Ao030=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=pcn7aP3U/8tPWDBnLiqtHZK99fBfRKYWSuZLMrC2SzVpN/nP+66PSjKwAif9q1bhtpisOUl/L8PDVIzChQ86rBIHFbEsREKlW1oxXf5FTS3jr8iWUPLIcMSfX/yM2ZI4vZ5yYgiaMaXr6f1O6A9KTX0xbsRc05NU7OSLsclug9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=profitiq.pl; spf=pass smtp.mailfrom=profitiq.pl; arc=pass smtp.client-ip=217.61.97.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=profitiq.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=profitiq.pl
Authentication-Results: profitiq.pl; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; d=profitiq.pl; s=default; a=rsa-sha256; cv=none; t=1740733775;
	b=BBJbTUx8z7wOa7z/049NvHF459iy/XIEQpJyqUOA7ICv/+zLgxxxYBsQ0PkRYtTKO5qP
	 XkYxt4xUgqNoOSYCPnf27iUDToIheAlsxfCD9ciBVKZmQEMlD9URVMpbyMUGYQxWFnVfz
	 PL/khtnt2APhClKg7B/O7MiLz7ds7X96ouYRebHexud5ITtU1W9tn1M2rUxEPUSYYZgeq
	 cOwZOTqYGIzo0tVfB3xnSTG+uiOkKfnTU3FAPnw3HR46Fe4IyvW64LlHhXInmJzNhWtBx
	 4N6e6IddyiIjKo1wJHCskpPCc2buUhbgeB06HN86oCrDlOnXbcieXvEZPj6xhPZJc6w==
ARC-Message-Signature: i=1; d=profitiq.pl; s=default; a=rsa-sha256;
	c=relaxed/simple; t=1740733775;
	h=Message-ID:Date:From:Subject:From;
	bh=e8QY90WF0s922aqFGIlQWUD16N2CFUeuI5eM65Ao030=;
	b=RHd6JHJAR1REfOa+n7lo1zEc2aS/DnFqZ938j317Gwm2foZRzng/dW9VwztsInhd/hcL
	 O14VwEwhGOFJ2mQAInbu081mQvYG3DjrZ/cLSZI9l3dveDhj/xxFfxuyuxrGLBAd4phoB
	 L6GnJqHJqAeu6i3UAoUDErY+C6sMFpKxsNTuOXq01e0wcn+OFOYmiP4xCB1iSqBINYmxU
	 OKMBfoX9Ps8MnF0Eb9WJdD/xohSjyVt1BMHcSa0e2c31eqj7NWQjhDa3Gx3UkVX5ZZxfd
	 Sm8t9tSKZHdgcAEV3y4Yu0GBu5gviWCf1Ieg+0qA0NJdRvF8nCiiOwhYkS9FQFoPXoA==
ARC-Authentication-Results: i=1; profitiq.pl; arc=none smtp.remote-ip=127.0.0.1
Received: by mail.profitiq.pl (Postfix, from userid 1002)
	id CFBB982F59; Fri, 28 Feb 2025 10:08:48 +0100 (CET)
Received: by mail.profitiq.pl for <sparclinux@vger.kernel.org>; Fri, 28 Feb 2025 09:08:04 GMT
Message-ID: <20250228094540-0.1.6.554.0.g6r75gc9cv@profitiq.pl>
Date: Fri, 28 Feb 2025 09:08:04 GMT
From: "Damian Czarnecki" <damian.czarnecki@profitiq.pl>
To: <sparclinux@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.profitiq.pl
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Damian Czarnecki
