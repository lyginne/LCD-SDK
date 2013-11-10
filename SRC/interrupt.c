void SetVector(unsigned char xdata * Address, void * Vector) 
{ 
	unsigned char xdata * TmpVector; // ¬ременна€ переменна€
	// ѕервым байтом по указанному адресу записываетс€ 
	// код команды передачи управлени€ ljmp, равный 02h
	*Address = 0x02; 
	// ƒалее записываетс€ адрес перехода Vector
	TmpVector = (unsigned char xdata *) (Address + 1); 
	*TmpVector = (unsigned char) ((unsigned short)Vector >> 8); 
	++TmpVector; 
	*TmpVector = (unsigned char) Vector;
// “аким образом, по адресу Address теперь 
// располагаетс€ инструкци€ ljmp Vector
}