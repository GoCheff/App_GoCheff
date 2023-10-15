String translateCartStatus(String status) {
  switch (status) {
    case 'open':
      return 'aberto';
    case 'sent':
      return 'enviado para o chef';
    case 'approved':
      return 'aguardando pagamento';
    case 'rejected':
      return 'rejeitado pelo chef';
    case 'paid':
      return 'pago';
    case 'cancelled':
      return 'cancelado';
    case 'finished':
      return 'finalizado';
    default:
      return 'desconhecido';
  }
}